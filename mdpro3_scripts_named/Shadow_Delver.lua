--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 暗影潜伏者  (ID: 57827484)
-- Type: Monster / Effect / Gemini
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1500 | DEF 500
--
-- Effect Text:
-- 这张卡在墓地或者场上表侧表示存在的场合，当作通常怪兽使用。场上表侧表示存在的这张卡可以作当通常召唤使用的再度召唤，这张卡当作效果怪兽使用并得到以下效果。
-- ●选择自己场上表侧表示存在的1只暗属性·4星以下怪兽发动。选择怪兽这个回合可以直接攻击对方玩家。这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--シャドウ・ダイバー
function c57827484.initial_effect(c)
	aux.EnableDualAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(57827484,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c57827484.condition)
	e1:SetTarget(c57827484.target)
	e1:SetOperation(c57827484.operation)
	c:RegisterEffect(e1)
end
function c57827484.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsDualState(e) and Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c57827484.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_DARK) and not c:IsHasEffect(EFFECT_DIRECT_ATTACK)
end
function c57827484.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c57827484.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c57827484.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c57827484.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c57827484.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DIRECT_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
