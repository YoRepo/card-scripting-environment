--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: The Arrival Cyberse @Ignister  (ID: 11738489)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 6
-- Link Arrows: Top, Left, Right, Bottom-Left, Bottom, Bottom-Right
-- ATK 0
-- Setcode: 0x93, 0x135
-- Scope: OCG / TCG
--
-- Effect Text:
-- 3+ monsters with different Attributes
-- You can only control 1 "The Arrival Cyberse @Ignister".
-- The original ATK of this card becomes 1000 x the number of materials used for its Link Summon.
-- Unaffected by other cards' effects.
-- Once per turn: You can target 1 other monster on the field; destroy it, and if you do, Special
-- Summon 1 "@Ignister Token" (Cyberse/DARK/Level 1/ATK 0/DEF 0) to your zone this card points to.
--[[ __CARD_HEADER_END__ ]]

--ジ・アライバル・サイバース＠イグニスター
function c11738489.initial_effect(c)
	c:SetUniqueOnField(1,0,11738489)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,nil,3,6,c11738489.lcheck)
	--base atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c11738489.matcheck)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c11738489.efilter)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c11738489.destg)
	e3:SetOperation(c11738489.desop)
	c:RegisterEffect(e3)
end
function c11738489.lcheck(g)
	return g:GetClassCount(Card.GetLinkAttribute)==g:GetCount()
end
function c11738489.matcheck(e,c)
	local ct=c:GetMaterialCount()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(ct*1000)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
function c11738489.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c11738489.cfilter(c,g,ct)
	return (c:IsType(TYPE_MONSTER) and ct~=0) or (ct==0 and g:IsContains(c))
end
function c11738489.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local zone=bit.band(c:GetLinkedZone(tp),0x1f)
	local ct=Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)
	local lg=c:GetLinkedGroup():Filter(Card.IsControler,nil,tp)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c11738489.cfilter(chkc,lg,ct) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c11738489.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,lg,ct)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,11738490,0x135,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK,POS_FACEUP,tp,0,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c11738489.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c,lg,ct)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
end
function c11738489.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		if not c:IsRelateToEffect(e) then return end
		local zone=bit.band(c:GetLinkedZone(tp),0x1f)
		if Duel.IsPlayerCanSpecialSummonMonster(tp,11738490,0x135,TYPES_TOKEN_MONSTER,0,0,1,RACE_CYBERSE,ATTRIBUTE_DARK,POS_FACEUP,tp,0,zone) then
			local token=Duel.CreateToken(tp,11738490)
			Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP,zone)
		end
	end
end
