--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Mystical Knight of Jackal  (ID: 98745000)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level: 7
-- ATK 2700 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card destroys 1 monster on your opponent's side of the field and sends it to your
-- opponent's Graveyard as a result of battle, you can then return the card to the top of your
-- opponent's Deck.
--[[ __CARD_HEADER_END__ ]]

--ジャッカルの聖戦士
function c98745000.initial_effect(c)
	--to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98745000,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCondition(c98745000.tdcon)
	e1:SetTarget(c98745000.tdtg)
	e1:SetOperation(c98745000.tdop)
	c:RegisterEffect(e1)
end
function c98745000.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not c:IsRelateToBattle() or c:IsFacedown() then return false end
	return bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER) and bc:IsControler(1-tp)
end
function c98745000.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc:IsAbleToDeck() end
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,bc,1,0,0)
end
function c98745000.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKTOP,REASON_EFFECT)
	end
end
