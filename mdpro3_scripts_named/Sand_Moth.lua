--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 沙沼怪  (ID: 73648243)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1000 | DEF 2000
--
-- Effect Text:
-- 里侧守备表示的这张卡被战斗以外的方式破坏送去墓地时，原本的攻击力·守备力交换并在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--サンドモス
function c73648243.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73648243,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c73648243.spcon)
	e1:SetTarget(c73648243.sptg)
	e1:SetOperation(c73648243.spop)
	c:RegisterEffect(e1)
end
function c73648243.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetReason(),0x41)==0x41 and c:IsPreviousLocation(LOCATION_MZONE)
		and c:IsPreviousPosition(POS_FACEDOWN_DEFENSE)
end
function c73648243.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c73648243.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local batk=c:GetBaseAttack()
	local bdef=c:GetBaseDefense()
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(bdef)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		e2:SetValue(batk)
		c:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
