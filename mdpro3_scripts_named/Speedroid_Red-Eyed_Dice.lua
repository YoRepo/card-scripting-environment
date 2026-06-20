--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 疾行机人 赤目骰子  (ID: 16725505)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 8214
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功时，以「疾行机人 赤目骰子」以外的自己场上1只「疾行机人」怪兽为对象，宣言1～6的任意等级才能发动。那只怪兽的等级直到回合结束时变成宣言的等级。
--[[ __CARD_HEADER_END__ ]]

--SR赤目のダイス
function c16725505.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16725505,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c16725505.tg)
	e1:SetOperation(c16725505.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c16725505.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x2016) and not c:IsCode(16725505) and c:GetLevel()>0
end
function c16725505.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c16725505.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c16725505.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c16725505.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local lv=g:GetFirst():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINGMSG_LVRANK)
	e:SetLabel(Duel.AnnounceLevel(tp,1,6,lv))
end
function c16725505.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
