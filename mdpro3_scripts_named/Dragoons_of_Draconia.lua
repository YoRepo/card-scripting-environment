--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 德拉科尼亚的兽龙骑兵  (ID: 73779005)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 4
-- Pendulum Scales: L2 / R2
-- ATK 1800 | DEF 200
--
-- Effect Text:
-- ←2 【灵摆】 2→
-- ①：1回合1次，自己的通常怪兽战斗破坏对方怪兽的伤害计算后才能发动。从卡组把1只4星以上的通常怪兽加入手卡。
-- 【怪兽描述】
-- 龙人族国家德拉科尼亚帝国所拥有的龙骑士团陆兵部队。使用鸟铳与铁枪组合攻击而无懈可击，令雷普提尔皇国等周边国家有所畏惧。
--[[ __CARD_HEADER_END__ ]]

--ドラコニアの獣竜騎兵
function c73779005.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c73779005.thcon)
	e2:SetTarget(c73779005.thtg)
	e2:SetOperation(c73779005.thop)
	c:RegisterEffect(e2)
end
function c73779005.thcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if d:IsControler(tp) then a,d=d,a end
	return a:IsType(TYPE_NORMAL) and d:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c73779005.filter(c)
	return c:IsType(TYPE_NORMAL) and c:IsLevelAbove(4) and c:IsAbleToHand()
end
function c73779005.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73779005.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c73779005.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c73779005.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
