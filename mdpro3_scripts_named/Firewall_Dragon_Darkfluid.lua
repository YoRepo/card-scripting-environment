--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 防火龙·暗流体  (ID: 68934651)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 3000 | LINK
-- Setcode: 399
--
-- Effect Text:
-- 效果怪兽3只以上
-- ①：这张卡连接召唤的场合才能发动。自己墓地的电子界族怪兽种类（仪式·融合·同调·超量）数量的指示物给这张卡放置。
-- ②：这张卡的攻击力在战斗阶段内上升这张卡的指示物数量×2500。
-- ③：对方把怪兽的效果发动时，把这张卡1个指示物取除才能发动。那个发动无效。这个效果在从这张卡的攻击宣言时到伤害步骤结束时发动的场合，这张卡再1次可以继续攻击。
--[[ __CARD_HEADER_END__ ]]

--ファイアウォール・ドラゴン・ダークフルード
function c68934651.initial_effect(c)
	c:EnableCounterPermit(0x52)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),3)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68934651,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c68934651.ctcon)
	e1:SetTarget(c68934651.cttg)
	e1:SetOperation(c68934651.ctop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c68934651.atkcon)
	e2:SetValue(c68934651.atkval)
	c:RegisterEffect(e2)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(68934651,1))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c68934651.discon)
	e3:SetCost(c68934651.discost)
	e3:SetTarget(c68934651.distg)
	e3:SetOperation(c68934651.disop)
	c:RegisterEffect(e3)
end
function c68934651.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c68934651.cfilter(c,type)
	return c:IsRace(RACE_CYBERSE) and c:IsType(type)
end
function c68934651.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=0
	for i,type in ipairs({TYPE_FUSION,TYPE_RITUAL,TYPE_SYNCHRO,TYPE_XYZ}) do
		if Duel.IsExistingMatchingCard(c68934651.cfilter,tp,LOCATION_GRAVE,0,1,nil,type) then
			ct=ct+1
		end
	end
	if chk==0 then return ct>0 and e:GetHandler():IsCanAddCounter(0x52,ct) end
end
function c68934651.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local ct=0
	for i,type in ipairs({TYPE_FUSION,TYPE_RITUAL,TYPE_SYNCHRO,TYPE_XYZ}) do
		if Duel.IsExistingMatchingCard(c68934651.cfilter,tp,LOCATION_GRAVE,0,1,nil,type) then
			ct=ct+1
		end
	end
	if ct>0 then
		c:AddCounter(0x52,ct)
	end
end
function c68934651.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c68934651.atkval(e,c)
	return c:GetCounter(0x52)*2500
end
function c68934651.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and Duel.IsChainNegatable(ev) and re:IsActiveType(TYPE_MONSTER)
end
function c68934651.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x52,1,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x52,1,REASON_COST)
end
function c68934651.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if Duel.GetAttacker()==e:GetHandler() then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
end
function c68934651.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateActivation(ev)
	if e:GetLabel()==1 and c:IsRelateToEffect(e) and c:IsChainAttackable(0) then
		Duel.ChainAttack()
	end
end
