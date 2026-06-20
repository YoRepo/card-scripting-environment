--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑羽-沙尘之哈麦丹  (ID: 77152542)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 2
-- ATK 800 | DEF 800
-- Setcode: 51
--
-- Effect Text:
-- 「黑羽-沙尘之哈麦丹」的①的方法的特殊召唤1回合只能有1次。
-- ①：自己场上有「黑羽-沙尘之哈麦丹」以外的「黑羽」怪兽存在的场合，这张卡可以从手卡特殊召唤。
-- ②：这张卡召唤·特殊召唤成功时，以这张卡以外的自己场上1只「黑羽」怪兽为对象才能发动。这张卡的等级上升那只怪兽的等级数值。
--[[ __CARD_HEADER_END__ ]]

--BF－砂塵のハルマッタン
function c77152542.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,77152542+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c77152542.spcon)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c77152542.target)
	e2:SetOperation(c77152542.operation)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c77152542.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and not c:IsCode(77152542)
end
function c77152542.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c77152542.cfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c77152542.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x33) and c:IsLevelAbove(1)
end
function c77152542.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c77152542.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(c77152542.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c77152542.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c77152542.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
