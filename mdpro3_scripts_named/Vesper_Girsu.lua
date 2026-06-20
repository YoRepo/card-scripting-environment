--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 宵星之闪光  (ID: 97345699)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：对方场上的怪兽数量比自己场上的怪兽多2只以上的场合才能发动。对方可以把自身场上的怪兽任意数量送去墓地。自己让对方场上的怪兽数量的以下效果适用。
-- ●0只：自己基本分变成一半。
-- ●1只：对方回复2000基本分。
-- ●2只：对方手卡全部直到结束阶段表侧除外。
-- ●3只以上：这个回合，对方不能把怪兽的效果发动。
--[[ __CARD_HEADER_END__ ]]

--宵星の閃光
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_RECOVER+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.con)
	e1:SetTarget(s.tg)
	e1:SetOperation(s.op)
	c:RegisterEffect(e1)
end
function s.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)-2
end
function s.tgfilter(c,e)
	return c:IsAbleToGrave() and not c:IsImmuneToEffect(e)
end
function s.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(s.tgfilter,tp,0,LOCATION_MZONE,nil,e)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function s.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.tgfilter,tp,0,LOCATION_MZONE,nil,e)
	if g:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(id,1)) then
		local tg=g:FilterSelect(1-tp,aux.NOT(Card.IsImmuneToEffect),1,g:GetCount(),nil,e)
		Duel.SendtoGrave(tg,REASON_EFFECT)
	end
	Duel.AdjustAll()
	local ss=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
	if ss==0 then
		Duel.SetLP(tp,math.ceil(Duel.GetLP(tp)/2))
	elseif ss==1 then
		Duel.Recover(1-tp,2000,REASON_EFFECT)
	elseif ss==2 then
		local rg=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if Duel.Remove(rg,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)~=0 then
			local og=Duel.GetOperatedGroup()
			local fid=og:GetFirst():GetFieldID()
			for tc in aux.Next(og) do
				tc:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,fid)
			end
			og:KeepAlive()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetLabelObject(og)
			e1:SetCondition(s.retcon)
			e1:SetOperation(s.retop)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	elseif ss>=3 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ACTIVATE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(0,1)
		e1:SetValue(s.actlimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.retfilter(c,fid)
	return c:GetFlagEffectLabel(id)==fid
end
function s.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(s.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function s.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(s.retfilter,nil,e:GetLabel())
	g:DeleteGroup()
	for tc in aux.Next(sg) do
		Duel.SendtoHand(tc,tc:GetPreviousControler(),REASON_EFFECT)
	end
end
function s.actlimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
