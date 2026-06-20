--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 幻惑之大花草  (ID: 31440542)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Plant
-- Level 2
-- ATK 300 | DEF 900
--
-- Effect Text:
-- 反转：直到回合结束前，得到对方场上的1只表侧表示的怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--幻惑のラフレシア
function c31440542.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31440542,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c31440542.ctltg)
	e1:SetOperation(c31440542.ctlop)
	c:RegisterEffect(e1)
end
function c31440542.filter(c)
	return c:IsFaceup() and c:IsAbleToChangeControler()
end
function c31440542.ctltg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c31440542.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c31440542.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c31440542.ctlop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.GetControl(tc,tp,PHASE_END,1)
	end
end
