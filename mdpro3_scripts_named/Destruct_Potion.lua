--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 破坏疗药  (ID: 18739764)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择自己场上存在的1只怪兽发动。选择的怪兽破坏，自己基本分回复破坏的怪兽的攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--デストラクト・ポーション
function c18739764.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c18739764.target)
	e1:SetOperation(c18739764.activate)
	c:RegisterEffect(e1)
end
function c18739764.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	if g:GetFirst():IsFaceup() then
		Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetAttack())
	end
end
function c18739764.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local atk=tc:IsFaceup() and tc:GetAttack() or 0
		if Duel.Destroy(tc,REASON_EFFECT)>0 and atk~=0 then
			Duel.Recover(tp,atk,REASON_EFFECT)
		end
	end
end
