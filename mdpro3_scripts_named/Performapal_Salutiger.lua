--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 娱乐伙伴 士兵虎  (ID: 44364077)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 4
-- ATK 1700 | DEF 500
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴 士兵虎」的效果1回合只能使用1次。
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。从卡组把1只「娱乐伙伴」灵摆怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--EMヘイタイガー
function c44364077.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44364077,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1,44364077)
	e1:SetCondition(c44364077.condition)
	e1:SetTarget(c44364077.target)
	e1:SetOperation(c44364077.operation)
	c:RegisterEffect(e1)
end
function c44364077.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c44364077.filter(c)
	return c:IsSetCard(0x9f) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c44364077.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44364077.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44364077.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44364077.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
