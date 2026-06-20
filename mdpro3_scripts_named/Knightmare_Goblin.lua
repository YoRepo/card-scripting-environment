--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 梦幻崩影·哥布林  (ID: 39064822)
-- Type: Monster / Effect / Link
-- Attribute: WIND
-- Race: Fiend
-- ATK 1300 | LINK
-- Setcode: 11272466
--
-- Effect Text:
-- 卡名不同的怪兽2只
-- ①：这张卡在自己回合连接召唤的场合，丢弃1张手卡才能发动。这个效果的发动时这张卡是互相连接状态的场合，自己可以抽1张。这个回合，自己在通常召唤外加上只有1次，自己主要阶段可以从手卡把1只怪兽在作为这张
-- 卡所连接区的自己场上召唤。
-- ②：只要这张卡在怪兽区域存在，双方不能把自己场上的互相连接状态的怪兽作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--トロイメア・ゴブリン
function c39064822.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,nil,2,2,c39064822.lcheck)
	c:EnableReviveLimit()
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39064822,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c39064822.sumcon)
	e1:SetCost(c39064822.sumcost)
	e1:SetTarget(c39064822.sumtg)
	e1:SetOperation(c39064822.sumop)
	c:RegisterEffect(e1)
	--cannot target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c39064822.tgtg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c39064822.lcheck(g,lc)
	return g:GetClassCount(Card.GetLinkCode)==g:GetCount()
end
function c39064822.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK) and Duel.GetTurnPlayer()==tp
end
function c39064822.sumcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c39064822.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSummon(tp) and Duel.IsPlayerCanAdditionalSummon(tp) and Duel.GetFlagEffect(tp,39064822)==0 end
	if e:GetHandler():GetMutualLinkedGroupCount()>0 then
		e:SetCategory(CATEGORY_DRAW)
		e:SetLabel(1)
	else
		e:SetCategory(0)
		e:SetLabel(0)
	end
end
function c39064822.sumop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==1 and Duel.IsPlayerCanDraw(tp,1)
		and Duel.SelectYesNo(tp,aux.Stringid(39064822,1)) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
	if Duel.GetFlagEffect(tp,39064822)~=0 then return end
	local c=e:GetHandler()
	local fid=c:GetFieldID()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39064822,2))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_HAND,0)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetLabel(fid)
	e1:SetCondition(c39064822.sumcon2)
	e1:SetValue(c39064822.sumval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,39064822,RESET_PHASE+PHASE_END,0,1)
end
function c39064822.sumcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFieldID()==e:GetLabel()
end
function c39064822.sumval(e,c)
	local c=e:GetHandler()
	local sumzone=c:GetLinkedZone()
	local relzone=-bit.lshift(1,c:GetSequence())
	return 0,sumzone,relzone
end
function c39064822.tgtg(e,c)
	return c:GetMutualLinkedGroupCount()>0
end
