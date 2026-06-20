--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: DD 巴风特  (ID: 19808608)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1400 | DEF 1800
-- Setcode: 175
--
-- Effect Text:
-- ①：1回合1次，以「DD 巴风特」以外的自己场上1只「DD」怪兽为对象，宣言1～8的任意等级才能发动。那只怪兽直到回合结束时变成宣言的等级。这个效果的发动后，直到回合结束时自己不是「DD」怪兽不能特殊
-- 召唤。
--[[ __CARD_HEADER_END__ ]]

--DDバフォメット
function c19808608.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c19808608.lvtg)
	e1:SetOperation(c19808608.lvop)
	c:RegisterEffect(e1)
end
function c19808608.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xaf) and not c:IsCode(19808608) and c:GetLevel()>0
end
function c19808608.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c19808608.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c19808608.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c19808608.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local lv=g:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceLevel(tp,1,8,lv))
end
function c19808608.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c19808608.splimit)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c19808608.splimit(e,c)
	return not c:IsSetCard(0xaf)
end
