--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 防守罚则  (ID: 48653261)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 选择场上1只怪兽。这个回合选择的怪兽变成守备表示的场合，从自己卡组抽1张卡。
--[[ __CARD_HEADER_END__ ]]

--ガードペナルティ
function c48653261.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c48653261.target)
	e1:SetOperation(c48653261.activate)
	c:RegisterEffect(e1)
end
function c48653261.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c48653261.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHANGE_POS)
		e1:SetCountLimit(1)
		e1:SetCondition(c48653261.drcon)
		e1:SetOperation(c48653261.drop)
		e1:SetLabel(tc:GetRealFieldID())
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c48653261.filter(c,fid)
	return c:GetRealFieldID()==fid and c:IsDefensePos() and c:IsPreviousPosition(POS_ATTACK)
end
function c48653261.drcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c48653261.filter,1,nil,e:GetLabel())
end
function c48653261.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,1,REASON_EFFECT)
	e:Reset()
end
