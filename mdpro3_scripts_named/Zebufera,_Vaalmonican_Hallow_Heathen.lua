--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 异响鸣之神异-风暴恶魔  (ID: 2815176)
-- Type: Monster / Effect / Link
-- Attribute: LIGHT
-- Race: Fiend
-- ATK 2500 | LINK
-- Setcode: 419
--
-- Effect Text:
-- 效果怪兽1只
-- 这张卡的连接召唤若非自己的灵摆区域的恶魔族怪兽卡的响鸣指示物是3个以上的场合则不能进行，自己对「异响鸣之神异-风暴恶魔」1回合只能有1次特殊召唤。
-- ①：自己场上的卡被战斗·效果破坏的场合，可以作为代替把自己的灵摆区域3个响鸣指示物取除。
-- ②：对方回合1次，以自己的墓地·除外状态的1张「异响鸣」通常魔法·通常陷阱卡为对象才能发动。那张魔法·陷阱卡发动时的效果适用。
--[[ __CARD_HEADER_END__ ]]

--ヴァルモニカの神異－ゼブフェーラ
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsType,TYPE_EFFECT),1,1)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_COST)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCost(s.spcost)
	c:RegisterEffect(e1)
	--spsum once
	c:SetSPSummonOnce(id)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(s.desreptg)
	e2:SetValue(s.desrepval)
	e2:SetOperation(s.desrepop)
	c:RegisterEffect(e2)
	--copy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(s.cpcon)
	e3:SetTarget(s.cptg)
	e3:SetOperation(s.cpop)
	c:RegisterEffect(e3)
end
function s.cfilter(c)
	return c:GetOriginalRace()&RACE_FIEND>0 and c:GetOriginalType()&TYPE_MONSTER>0 and c:GetCounter(0x6a)>2
end
function s.spcost(e,c,tp,st)
	if st&SUMMON_TYPE_LINK~=SUMMON_TYPE_LINK then return true end
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_PZONE,0,1,nil)
end
function s.desrepchk(g,tp)
	local tl=0
	for tc in aux.Next(g) do
		local ct=0
		for i=1,3 do
			if tc:IsCanRemoveCounter(tp,0x6a,i,REASON_COST) then ct=i end
		end
		tl=tl+ct
	end
	return tl>2
end
function s.desrepfilter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and c:IsControler(tp) and c:IsOnField()
end
function s.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	if chk==0 then return eg:IsExists(s.desrepfilter,1,nil,tp)
		and g:CheckSubGroup(s.desrepchk,1,2) end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function s.desrepval(e,c)
	return s.desrepfilter(c,e:GetHandlerPlayer())
end
function s.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,id)
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	local ct=0
	while ct<3 do
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local tc=g:FilterSelect(tp,Card.IsCanRemoveCounter,1,1,nil,tp,0x6a,1,REASON_COST):GetFirst()
		tc:RemoveCounter(tp,0x6a,1,REASON_COST)
		ct=ct+1
	end
end
function s.cpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end
function s.filter(c)
	local typ=c:GetType()
	return c:IsFaceupEx() and c:IsSetCard(0x1a3) and (typ==TYPE_SPELL or typ==TYPE_TRAP)
		and c:CheckActivateEffect(false,true,false)
end
function s.cptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		local te=e:GetLabelObject()
		local tg=te:GetTarget()
		return tg and tg(e,tp,eg,ep,ev,re,r,rp,0,chkc)
	end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,s.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil):GetFirst()
	local te,ceg,cev,cre,cr,crp=tc:CheckActivateEffect(false,true,true)
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(e)
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
end
function s.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if not (te and te:GetHandler():IsRelateToEffect(e)) then return end
	e:SetLabelObject(te:GetLabelObject())
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
