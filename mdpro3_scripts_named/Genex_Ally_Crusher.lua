--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 盟军·次世代轰击兵  (ID: 27827903)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 2000
-- Setcode: 2
--
-- Effect Text:
-- ①：1回合1次，持有和这张卡相同属性的怪兽在自己场上召唤时，以对方场上1张卡为对象才能发动。那张对方的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・クラッシャー
function c27827903.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27827903,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c27827903.descon)
	e1:SetTarget(c27827903.destg)
	e1:SetOperation(c27827903.desop)
	c:RegisterEffect(e1)
end
function c27827903.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst()~=e:GetHandler() and eg:GetFirst():GetControler()==e:GetHandler():GetControler()
		and eg:GetFirst():IsAttribute(e:GetHandler():GetAttribute())
end
function c27827903.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c27827903.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
