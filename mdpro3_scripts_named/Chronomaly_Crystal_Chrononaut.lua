--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Chronomaly Crystal Chrononaut  (ID: 93730230)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Psychic
-- Rank: 3
-- ATK 2100 | DEF 1000
-- Setcode: 0x70
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Level 3 monsters
-- Once per turn, when this card is targeted for an attack: You can detach 1 Xyz Material from this
-- card; this turn, this card cannot be destroyed by battle or by card effects, also your opponent
-- takes any Battle Damage you would have taken from battles involving this card.
--[[ __CARD_HEADER_END__ ]]

--先史遺産クリスタル・エイリアン
function c93730230.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,3,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93730230,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c93730230.cost)
	e1:SetOperation(c93730230.operation)
	c:RegisterEffect(e1)
end
function c93730230.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c93730230.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
		c:RegisterEffect(e3)
	end
end
