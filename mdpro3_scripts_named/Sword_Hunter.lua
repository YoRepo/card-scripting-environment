--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Sword Hunter  (ID: 51345461)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 7
-- ATK 2450 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the end of the Battle Phase, if this card destroyed a monster(s) by battle and sent it to the
-- Graveyard this Battle Phase: Equip all those monsters from the Graveyard to this card as an Equip
-- Spell Card(s) with this effect.
-- ● The equipped monster gains 200 ATK.
--[[ __CARD_HEADER_END__ ]]

--ソードハンター
function c51345461.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51345461,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c51345461.eqtg)
	e1:SetOperation(c51345461.eqop)
	c:RegisterEffect(e1)
end
function c51345461.filter(c,rc,tid)
	return c:IsReason(REASON_BATTLE) and c:GetReasonCard()==rc and c:GetTurnID()==tid and not c:IsForbidden()
end
function c51345461.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c51345461.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e:GetHandler(),Duel.GetTurnCount())
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,g:GetCount(),0,0)
end
function c51345461.eqop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ft<=0 then return end
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c51345461.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,e:GetHandler(),Duel.GetTurnCount())
	if g:GetCount()==0 then return end
	if g:GetCount()>ft then return end
	local tc=g:GetFirst()
	while tc do
		Duel.Equip(tp,tc,c,false,true)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c51345461.eqlimit)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_EQUIP)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(200)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.EquipComplete()
end
function c51345461.eqlimit(e,c)
	return e:GetOwner()==c
end
