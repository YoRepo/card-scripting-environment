--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 武神器-蜂  (ID: 88940154)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1700 | DEF 500
-- Setcode: 136
--
-- Effect Text:
-- 自己的主要阶段时，自己场上有名字带有「武神」的兽战士族怪兽存在的场合，把墓地的这张卡从游戏中除外才能发动。选择对方场上1张魔法·陷阱卡破坏。「武神器-蜂」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--武神器－ハチ
function c88940154.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88940154,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,88940154)
	e1:SetCondition(c88940154.descon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c88940154.destg)
	e1:SetOperation(c88940154.desop)
	c:RegisterEffect(e1)
end
function c88940154.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
end
function c88940154.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c88940154.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c88940154.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c88940154.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c88940154.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88940154.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c88940154.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c88940154.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
