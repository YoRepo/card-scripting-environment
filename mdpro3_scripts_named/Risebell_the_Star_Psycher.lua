--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 觉星师 莱斯贝尔特  (ID: 14812659)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Psychic
-- Level 4
-- ATK 1500 | DEF 1500
--
-- Effect Text:
-- 1回合1次，选择场上表侧表示存在的1只怪兽才能发动。选择的怪兽的等级上升1星。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--覚星師ライズベルト
function c14812659.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14812659,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetHintTiming(TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c14812659.target)
	e1:SetOperation(c14812659.operation)
	c:RegisterEffect(e1)
end
function c14812659.filter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function c14812659.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c14812659.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c14812659.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c14812659.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c14812659.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
