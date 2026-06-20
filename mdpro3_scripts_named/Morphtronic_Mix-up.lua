--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 组合变形斗士  (ID: 14613029)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 38
--
-- Effect Text:
-- 自己场上名字带有「变形斗士」的怪兽有2只以上表侧表示存在的场合，选择对方场上存在的2张卡发动。对方从那之中选择1张，对方选择的1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ブレンD
function c14613029.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c14613029.condition)
	e1:SetTarget(c14613029.target)
	e1:SetOperation(c14613029.operation)
	c:RegisterEffect(e1)
end
function c14613029.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x26)
end
function c14613029.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c14613029.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c14613029.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c14613029.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==0 then return
	elseif sg:GetCount()==1 then
		Duel.Destroy(sg,REASON_EFFECT)
	else
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
		local dg=sg:Select(1-tp,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
