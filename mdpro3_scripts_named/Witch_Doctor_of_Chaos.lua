--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 混沌咒术师  (ID: 75946257)
-- Type: Monster / Effect / Toon
-- Attribute: DARK
-- Race: Spellcaster
-- Level 2
-- ATK 500 | DEF 500
--
-- Effect Text:
-- 反转：从自己或对方的墓地里选择1张怪兽卡，将被选择的卡从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--混沌の呪術師
function c75946257.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75946257,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c75946257.target)
	e1:SetOperation(c75946257.operation)
	c:RegisterEffect(e1)
end
function c75946257.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c75946257.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c75946257.filter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c75946257.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,tc,1,tc:GetControler(),LOCATION_GRAVE)
	end
end
function c75946257.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
