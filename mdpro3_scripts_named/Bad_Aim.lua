--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 友方误射  (ID: 46253216)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方的魔法·陷阱·怪兽的效果发动时，以那张卡以外的场上1张卡为对象才能发动。作为对象的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--フレンドリーファイア
function c46253216.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c46253216.condition)
	e1:SetTarget(c46253216.target)
	e1:SetOperation(c46253216.activate)
	c:RegisterEffect(e1)
end
function c46253216.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c46253216.filter(c,rc)
	return c~=rc
end
function c46253216.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c46253216.filter(chkc,re:GetHandler()) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c46253216.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler(),re:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c46253216.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler(),re:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c46253216.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
