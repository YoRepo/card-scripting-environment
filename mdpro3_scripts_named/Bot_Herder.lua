--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 僵尸牧人  (ID: 45951104)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以对方场上1只里侧守备表示怪兽或者原本持有者是自己的表侧表示怪兽为对象才能发动。作为对象的怪兽不存在的场合或者作为对象的怪兽的原本持有者是自己的场合（里侧表示卡翻开确认），以下效果各适用。
-- ●给与对方200伤害。
-- ●除作为对象的怪兽外的对方场上的全部怪兽的控制权得到。
--[[ __CARD_HEADER_END__ ]]

--ボット・ハーダー
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c,tp)
	return c:IsFacedown() or (c:IsFaceup() and c:GetOwner()==tp)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	if g:GetCount()>0 and g:GetFirst():GetOwner()==tp then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,200)
	end
end
function s.ctfilter(c)
	return c:IsControlerCanBeChanged(true)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsOnField() and tc:IsFacedown() then Duel.ConfirmCards(tp,tc) end
	if not tc:IsRelateToChain() or tc:GetOwner()==tp then
		Duel.Damage(1-tp,200,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(s.ctfilter,tp,0,LOCATION_MZONE,tc)
		if g:GetCount()>0 then
			Duel.BreakEffect()
			Duel.GetControl(g,tp)
		end
	end
end
