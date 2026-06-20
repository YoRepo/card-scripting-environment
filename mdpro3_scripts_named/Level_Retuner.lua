--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 等级重调  (ID: 86223870)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的1只怪兽的等级下降最多2星。
--[[ __CARD_HEADER_END__ ]]

--レベル・リチューナー
function c86223870.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c86223870.target)
	e1:SetOperation(c86223870.activate)
	c:RegisterEffect(e1)
end
function c86223870.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(2)
end
function c86223870.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c86223870.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c86223870.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c86223870.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c86223870.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local lv=tc:GetLevel()
		local dlv=1
		if lv==1 then return
		elseif lv>2 then
			dlv=Duel.SelectOption(tp,aux.Stringid(86223870,0),aux.Stringid(86223870,1))+1
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-dlv)
		tc:RegisterEffect(e1)
	end
end
