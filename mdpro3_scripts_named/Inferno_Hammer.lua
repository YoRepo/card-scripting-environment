--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 业火之锤  (ID: 17185260)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 6
-- ATK 2400 | DEF 0
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽送去墓地时，以对方场上1只表侧表示怪兽为对象才能发动。那只对方的表侧表示怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--インフェルノ・ハンマー
function c17185260.initial_effect(c)
	--pos
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17185260,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c17185260.postg)
	e1:SetOperation(c17185260.posop)
	c:RegisterEffect(e1)
end
function c17185260.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c17185260.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c17185260.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17185260.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c17185260.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c17185260.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.ChangePosition(tc,POS_FACEDOWN_DEFENSE)
	end
end
