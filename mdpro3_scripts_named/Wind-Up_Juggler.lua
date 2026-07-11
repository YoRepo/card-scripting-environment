--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Wind-Up Juggler  (ID: 85682655)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level: 4
-- ATK 1700 | DEF 1000
-- Setcode: 0x58
-- Scope: OCG / TCG
--
-- Effect Text:
-- After damage calculation, if this card battled an opponent's monster: You can destroy that
-- opponent's monster.
-- This effect can be used only once while this card is face-up on the field.
--[[ __CARD_HEADER_END__ ]]

--ゼンマイジャグラー
function c85682655.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85682655,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c85682655.target)
	e1:SetOperation(c85682655.operation)
	c:RegisterEffect(e1)
end
function c85682655.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetAttacker()
	if tc==e:GetHandler() then tc=Duel.GetAttackTarget() end
	if chk==0 then return tc and tc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c85682655.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc==e:GetHandler() then tc=Duel.GetAttackTarget() end
	if tc:IsRelateToBattle() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
