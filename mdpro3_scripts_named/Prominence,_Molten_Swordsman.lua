--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 炎热刀 日珥  (ID: 89770167)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 4
-- ATK 1800 | DEF 600
--
-- Effect Text:
-- 1回合1次，把自己墓地存在的1只名字带有「熔岩」的怪兽从游戏中除外才能发动。这张卡的攻击力直到结束阶段时上升300。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--炎熱刀プロミネンス
function c89770167.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89770167,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c89770167.atcost)
	e1:SetOperation(c89770167.atop)
	c:RegisterEffect(e1)
end
function c89770167.cfilter(c)
	return c:IsSetCard(0x39) and c:IsAbleToRemoveAsCost()
end
function c89770167.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89770167.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c89770167.cfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c89770167.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
