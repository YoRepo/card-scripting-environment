--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 无限暗魔  (ID: 76520646)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当成通常召唤使用的再度召唤，这张卡变成当作效果怪兽使用并得到以下效果。
-- ●这张卡的攻击宣言时，可以把对方场上存在的1只表侧表示怪兽的表示形式改变。
--[[ __CARD_HEADER_END__ ]]

--インフィニティ・ダーク
function c76520646.initial_effect(c)
	aux.EnableDualAttribute(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76520646,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c76520646.postg)
	e1:SetOperation(c76520646.posop)
	c:RegisterEffect(e1)
end
function c76520646.filter(c)
	return c:IsFaceup() and c:IsCanChangePosition()
end
function c76520646.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c76520646.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c76520646.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c76520646.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c76520646.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
	end
end
