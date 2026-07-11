--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ninja Grandmaster Saizo  (ID: 37354507)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Warrior
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 2000
-- Setcode: 0x2b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 "Ninja" monsters
-- During your Main Phase: You can Set 1 "Ninjitsu Art" Spell/Trap directly from your Deck.
-- You can only use this effect of "Ninja Grandmaster Saizo" once per turn.
-- While this card points to a monster(s), this card cannot be targeted for an attack, also your
-- opponent cannot target it with card effects.
--[[ __CARD_HEADER_END__ ]]

--忍者マスター SAIZO
function c37354507.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0x2b),2,2)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37354507,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,37354507)
	e1:SetTarget(c37354507.settg)
	e1:SetOperation(c37354507.setop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c37354507.tgcon)
	e2:SetValue(aux.imval1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
end
function c37354507.setfilter(c)
	return c:IsSetCard(0x61) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c37354507.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c37354507.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c37354507.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c37354507.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 then
		Duel.SSet(tp,g)
	end
end
function c37354507.tgcon(e)
	return e:GetHandler():GetLinkedGroupCount()>0
end
