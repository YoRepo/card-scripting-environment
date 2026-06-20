--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 再转  (ID: 96015976)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：1回合1次，以场上1只持有和原本等级不同等级的怪兽为对象才能把这个效果发动。掷1次骰子。作为对象的怪兽的等级变成和出现的数目相同。
--[[ __CARD_HEADER_END__ ]]

--再転
function c96015976.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96015976,0))
	e2:SetCategory(CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1)
	e2:SetTarget(c96015976.target)
	e2:SetOperation(c96015976.operation)
	c:RegisterEffect(e2)
end
function c96015976.filter(c)
	local lv=c:GetLevel()
	local olv=c:GetOriginalLevel()
	return c:IsFaceup() and lv~=0 and lv~=olv and olv~=0
end
function c96015976.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c96015976.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c96015976.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c96015976.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c96015976.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local dc=Duel.TossDice(tp,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(dc)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
