--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 击灭龙 暗黑武装  (ID: 78144171)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Dragon
-- Rank 7
-- ATK 2800 | DEF 1000
--
-- Effect Text:
-- 7星怪兽×2只以上
-- 「击灭龙 暗黑武装」1回合1次也能在自己墓地的暗属性怪兽只有5只的场合，在自己场上的5星以上的龙族·暗属性怪兽上面重叠来超量召唤。
-- ①：把这张卡1个超量素材取除，以对方场上1张卡为对象才能发动。那张卡破坏。那之后，从自己墓地选1张卡除外。这个效果的发动后，直到回合结束时这张卡不能攻击。
--[[ __CARD_HEADER_END__ ]]

--撃滅龍 ダーク・アームド
function c78144171.initial_effect(c)
	--xyz summon
	c:EnableReviveLimit()
	aux.AddXyzProcedure(c,nil,7,2,c78144171.ovfilter,aux.Stringid(78144171,0),99,c78144171.xyzop)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(78144171,1))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c78144171.cost)
	e1:SetTarget(c78144171.target)
	e1:SetOperation(c78144171.activate)
	c:RegisterEffect(e1)
end
function c78144171.ovfilter(c)
	if Duel.GetMatchingGroupCount(Card.IsAttribute,c:GetControler(),LOCATION_GRAVE,0,nil,ATTRIBUTE_DARK)~=5 then return false end
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsLevelAbove(5)
end
function c78144171.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,78144171)==0 end
	Duel.RegisterFlagEffect(tp,78144171,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c78144171.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c78144171.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,LOCATION_GRAVE)
end
function c78144171.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(Card.IsAbleToRemove),tp,LOCATION_GRAVE,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		end
	end
end
