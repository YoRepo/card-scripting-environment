--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 雪暴战士  (ID: 96565487)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 3
-- ATK 1400 | DEF 400
-- Setcode: 102
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽的场合发动。把对方卡组最上面的卡确认，回到卡组最上面或最下面。
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
