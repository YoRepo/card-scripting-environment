--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 废品变更者  (ID: 1006081)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 1500 | DEF 900
-- Setcode: 67
--
-- Effect Text:
-- 「废品变更者」的效果1回合只能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，可以以场上1只「废品」怪兽为对象从以下效果选择1个发动。
-- ●作为对象的怪兽的等级上升1星。
-- ●作为对象的怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--ジャンク・チェンジャー
function c1006081.initial_effect(c)
	--lv up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1006081,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,1006081)
	e1:SetTarget(c1006081.target)
	e1:SetOperation(c1006081.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c1006081.filter(c)
	return c:IsFaceup() and c:GetLevel()>0 and c:IsSetCard(0x43)
end
function c1006081.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c1006081.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c1006081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c1006081.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	if g:GetFirst():IsLevel(1) then
		op=Duel.SelectOption(tp,aux.Stringid(1006081,1))
	else
		op=Duel.SelectOption(tp,aux.Stringid(1006081,1),aux.Stringid(1006081,2))
	end
	e:SetLabel(op)
end
function c1006081.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else
			e1:SetValue(-1)
		end
		tc:RegisterEffect(e1)
	end
end
