--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: The Fabled Unicore  (ID: 44155002)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 2300 | DEF 1000
-- Setcode: 0x35
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 "Fabled" Tuner + 1+ non-Tuner monsters
-- While you and your opponent have the same number of cards in hand, negate all cards and effects
-- activated by your opponent, and if you do, destroy those cards.
--[[ __CARD_HEADER_END__ ]]

--魔轟神獣ユニコール
function c44155002.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x35),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--disable and destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetOperation(c44155002.disop)
	c:RegisterEffect(e1)
end
function c44155002.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND) then return end
	local rc=re:GetHandler()
	if Duel.NegateEffect(ev,true) and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
