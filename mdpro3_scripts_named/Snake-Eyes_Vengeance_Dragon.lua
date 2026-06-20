--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 蛇眼断罪龙  (ID: 79415624)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dragon
-- Level 12
-- ATK 3000 | DEF 2500
-- Setcode: 412
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己·对方的主要阶段，以自己或对方的场上（表侧表示）·墓地1只怪兽为对象才能发动。那只怪兽当作永续魔法卡使用在原本持有者的魔法与陷阱区域表侧表示放置。下个回合，这张卡不能使用这个效果。
-- ②：自己·对方的战斗阶段，以场上1只怪兽和场上1张永续魔法卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--蛇眼の断罪龍
local s,id,o=GetID()
function s.initial_effect(c)
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--move
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e1:SetCondition(s.mvcon)
	e1:SetTarget(s.mvtg)
	e1:SetOperation(s.mvop)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(TIMING_BATTLE_START+TIMING_BATTLE_END)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.mvcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsMainPhase() and Duel.GetTurnCount()~=e:GetHandler():GetFlagEffectLabel(id)
end
function s.mvfilter(c,tp)
	local r=LOCATION_REASON_TOFIELD
	if not c:IsControler(c:GetOwner()) then
		if not c:IsAbleToChangeControler() then return false end
		r=LOCATION_REASON_CONTROL
	end
	return (c:IsLocation(LOCATION_MZONE) or c:IsType(TYPE_MONSTER) and not c:IsForbidden() and c:CheckUniqueOnField(c:GetOwner()))
		and c:IsFaceupEx() and Duel.GetLocationCount(c:GetOwner(),LOCATION_SZONE,tp,r)>0
end
function s.mvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_MZONE) and s.mvfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.mvfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=aux.SelectTargetFromFieldFirst(tp,s.mvfilter,tp,LOCATION_GRAVE+LOCATION_MZONE,LOCATION_GRAVE+LOCATION_MZONE,1,1,nil,tp)
	if g:GetFirst():IsLocation(LOCATION_GRAVE) then
		Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
	end
end
function s.mvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsType(TYPE_MONSTER) and aux.NecroValleyFilter()(tc)
		and not tc:IsImmuneToEffect(e)
		and Duel.MoveToField(tc,tp,tc:GetOwner(),LOCATION_SZONE,POS_FACEUP,true) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		tc:RegisterEffect(e1)
	end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,2,Duel.GetTurnCount()+1)
	end
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase()
end
function s.desfilter1(c,tp)
	return c:IsType(TYPE_MONSTER) and Duel.IsExistingTarget(s.desfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function s.desfilter2(c)
	return c:IsFaceup() and c:IsAllTypes(TYPE_CONTINUOUS|TYPE_SPELL)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(s.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,s.desfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,s.desfilter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,g1)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,g1:GetCount(),0,0)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
