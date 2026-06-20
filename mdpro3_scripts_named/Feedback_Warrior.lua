--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 啸叫战士  (ID: 50785356)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 800 | DEF 700
-- Setcode: 102
--
-- Effect Text:
-- 这张卡召唤·特殊召唤成功时，选择自己场上表侧表示存在的1只怪兽才能发动。选择的怪兽的等级变成3星。
--[[ __CARD_HEADER_END__ ]]

--ハウリング・ウォリアー
function c50785356.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50785356,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c50785356.target)
	e1:SetOperation(c50785356.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c50785356.filter(c)
	return c:IsFaceup() and not c:IsLevel(3) and c:IsLevelAbove(1)
end
function c50785356.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c50785356.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c50785356.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c50785356.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c50785356.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(3)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end
