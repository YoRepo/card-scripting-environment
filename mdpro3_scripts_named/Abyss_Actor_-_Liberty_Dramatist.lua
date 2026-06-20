--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 魔界剧团-自由剧作家  (ID: 65477143)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- Pendulum Scales: L8 / R8
-- ATK 1500 | DEF 1500
-- Setcode: 4332
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：自己或者对方的怪兽的攻击宣言时，丢弃1张手卡才能发动。这张卡在对方场上特殊召唤。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：这张卡从灵摆区域的特殊召唤成功的场合发动。这张卡的原本持有者从自身卡组把3张「魔界台本」魔法卡给对方观看，对方从那之中随机选1张。那1张卡在自身场上盖放，剩下的卡回到卡组。这个效果盖放的卡在结束阶
-- 段破坏。
-- ②：这张卡被破坏的场合才能发动。从自己墓地选1张「魔界台本」魔法卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--魔界劇団－リバティ・ドラマチスト
function c65477143.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--disable attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65477143,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,65477143)
	e1:SetCost(c65477143.atkcost)
	e1:SetTarget(c65477143.atktg)
	e1:SetOperation(c65477143.atkop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(65477143,1))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,65477144)
	e2:SetCondition(c65477143.thcon)
	e2:SetOperation(c65477143.thop)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(65477143,2))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,65477145)
	e3:SetTarget(c65477143.tdtg)
	e3:SetOperation(c65477143.tdop)
	c:RegisterEffect(e3)
end
function c65477143.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c65477143.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE,tp)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c65477143.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,1-tp,false,false,POS_FACEUP)
	end
end
function c65477143.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_PZONE)
end
function c65477143.thfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsSSetable() and c:IsSetCard(0x20ec)
end
function c65477143.thop(e,tp,eg,ep,ev,re,r,rp)
	local ts=e:GetHandler():GetOwner()
	local g=Duel.GetMatchingGroup(c65477143.thfilter,ts,LOCATION_DECK,0,nil)
	if g:GetCount()>=3 then
		Duel.Hint(HINT_SELECTMSG,ts,HINTMSG_SET)
		local sg=g:Select(ts,3,3,nil)
		Duel.ConfirmCards(1-ts,sg)
		Duel.Hint(HINT_SELECTMSG,1-ts,HINTMSG_SET)
		local tg=sg:RandomSelect(1-ts,1)
		local tc=tg:GetFirst()
		if tc and Duel.SSet(tp,tc,ts,false)~=0 then
			Duel.ShuffleDeck(ts)
			local c=e:GetHandler()
			local fid=c:GetFieldID()
			tc:RegisterFlagEffect(65477143,RESET_EVENT+RESETS_STANDARD,0,1,fid)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCountLimit(1)
			e1:SetLabel(fid)
			e1:SetLabelObject(tc)
			e1:SetCondition(c65477143.tgcon)
			e1:SetOperation(c65477143.tgop)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c65477143.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return tc:GetFlagEffectLabel(65477143)==e:GetLabel()
end
function c65477143.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Destroy(tc,REASON_EFFECT)
end
function c65477143.tdfilter(c)
	return c:IsSetCard(0x20ec) and c:IsType(TYPE_SPELL) and c:IsAbleToDeck()
end
function c65477143.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65477143.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end
function c65477143.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c65477143.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
