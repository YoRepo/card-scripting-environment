--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 盟军·次世代同暗兵  (ID: 68450517)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 200
-- Setcode: 2
--
-- Effect Text:
-- ①：1回合1次，以属性和这张卡相同的对方场上1只攻击表示怪兽为对象才能发动（这个效果发动的回合，这张卡不能攻击）。属性和这张卡相同的那只对方的攻击表示怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--A・ジェネクス・ドゥルダーク
function c68450517.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68450517,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c68450517.descost)
	e1:SetTarget(c68450517.destg)
	e1:SetOperation(c68450517.desop)
	c:RegisterEffect(e1)
end
function c68450517.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c68450517.filter(c,att)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsAttribute(att)
end
function c68450517.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp)
		and c68450517.filter(chkc,e:GetHandler():GetAttribute()) end
	if chk==0 then return Duel.IsExistingTarget(c68450517.filter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler():GetAttribute()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c68450517.filter,tp,0,LOCATION_MZONE,1,1,nil,e:GetHandler():GetAttribute())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c68450517.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsControler(1-tp) and c68450517.filter(tc,c:GetAttribute()) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
