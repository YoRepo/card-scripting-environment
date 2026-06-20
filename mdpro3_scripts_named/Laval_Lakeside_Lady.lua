--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 熔岩炎湖畔的淑女  (ID: 8041569)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 200 | DEF 200
-- Setcode: 57
--
-- Effect Text:
-- 自己墓地有名字带有「熔岩」的怪兽3种类以上存在的场合，把自己墓地存在的这张卡和1只名字带有「熔岩」的怪兽从游戏中除外才能发动。选择对方场上盖放的1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--ラヴァル炎湖畔の淑女
function c8041569.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetDescription(aux.Stringid(8041569,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c8041569.descon)
	e1:SetCost(c8041569.descost)
	e1:SetTarget(c8041569.destg)
	e1:SetOperation(c8041569.desop)
	c:RegisterEffect(e1)
end
function c8041569.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)>=3
end
function c8041569.cfilter(c)
	return c:IsSetCard(0x39) and c:IsAbleToRemoveAsCost()
end
function c8041569.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c8041569.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c8041569.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c8041569.filter(c)
	return c:IsFacedown()
end
function c8041569.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c8041569.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c8041569.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c8041569.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c8041569.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
