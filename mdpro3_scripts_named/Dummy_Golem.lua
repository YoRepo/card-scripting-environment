--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 替身石人  (ID: 13532663)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Rock
-- Level 2
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 反转：对方选择所控制的1只怪兽。选择怪兽和这张卡的控制权交换。
--[[ __CARD_HEADER_END__ ]]

--ダミー・ゴーレム
function c13532663.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13532663,0))
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c13532663.target)
	e1:SetOperation(c13532663.operation)
	c:RegisterEffect(e1)
end
function c13532663.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,0,0,0)
end
function c13532663.filter(c)
	local tp=c:GetControler()
	return c:IsAbleToChangeControler() and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c13532663.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) or not c:IsRelateToEffect(e)
		or not c:IsAbleToChangeControler() or Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)<=0
		or not Duel.IsExistingMatchingCard(c13532663.filter,tp,0,LOCATION_MZONE,1,nil) then
		return
	end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(1-tp,c13532663.filter,1-tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SwapControl(c,g:GetFirst(),0,0)
end
