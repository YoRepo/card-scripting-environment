--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: YZ-战车龙  (ID: 25119460)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level 6
-- ATK 2100 | DEF 2200
--
-- Effect Text:
-- 「Y-龙头」＋「Z-金属履带」
-- 把自己场上的上记卡除外的场合才能从额外卡组特殊召唤。这张卡不能作从墓地的特殊召唤。
-- ①：丢弃1张手卡，以对方场上1只里侧表示怪兽为对象才能发动。那只对方的里侧表示怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--YZ－キャタピラー・ドラゴン
function c25119460.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,65622692,64500000,true,true)
	aux.AddContactFusionProcedure(c,Card.IsAbleToRemoveAsCost,LOCATION_ONFIELD,0,Duel.Remove,POS_FACEUP,REASON_COST)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c25119460.splimit)
	c:RegisterEffect(e1)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(25119460,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c25119460.descost)
	e3:SetTarget(c25119460.destg)
	e3:SetOperation(c25119460.desop)
	c:RegisterEffect(e3)
end
function c25119460.splimit(e,se,sp,st)
	return not e:GetHandler():IsLocation(LOCATION_EXTRA+LOCATION_GRAVE)
end
function c25119460.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c25119460.filter(c)
	return c:IsFacedown()
end
function c25119460.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c25119460.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25119460.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c25119460.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c25119460.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and tc:IsFacedown() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
