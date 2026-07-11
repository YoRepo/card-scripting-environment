--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Blizzard Warrior  (ID: 96565487)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level: 3
-- ATK 1400 | DEF 400
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card destroys an opponent's monster by battle: Look at the top card of their Deck and place
-- it on the top or bottom of the Deck.
--[[ __CARD_HEADER_END__ ]]

--ブリザード・ウォリアー
function c96565487.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96565487,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c96565487.condition)
	e1:SetOperation(c96565487.operation)
	c:RegisterEffect(e1)
end
function c96565487.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c96565487.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,1)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
	local tc=g:GetFirst()
	local opt=Duel.SelectOption(tp,aux.Stringid(96565487,1),aux.Stringid(96565487,2))
	if opt==1 then
		Duel.MoveSequence(tc,opt)
	end
end
