--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 治愈波镜  (ID: 31281980)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 800 | DEF 1600
--
-- Effect Text:
-- 选择这张卡以外的自己场上表侧表示存在的1只怪兽发动。回复选择怪兽的等级×100的数值的基本分。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ヒール・ウェーバー
function c31281980.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31281980,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c31281980.rectg)
	e1:SetOperation(c31281980.recop)
	c:RegisterEffect(e1)
end
function c31281980.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c31281980.rectg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c31281980.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c31281980.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c31281980.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,g:GetFirst():GetLevel()*100)
end
function c31281980.recop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Recover(tp,tc:GetLevel()*100,REASON_EFFECT)
	end
end
