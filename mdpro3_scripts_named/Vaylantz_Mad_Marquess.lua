--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 群豪之狂化者-侯爵  (ID: 87897777)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Machine
-- Level 6
-- Pendulum Scales: L1 / R1
-- ATK 1700 | DEF 1700
-- Setcode: 381
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：场地区域有「群豪世界-百识公国」存在的场合或者自己场上有炎属性「群豪」怪兽存在的场合才能发动。这张卡在正对面的自己的主要怪兽区域特殊召唤。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面翻开。可以从那之中选1张「群豪」卡加入手卡。剩余回到卡组。
-- ②：怪兽区域的这张卡向其他的怪兽区域移动的场合才能发动。掷1次骰子，2～5出现的场合，选自己的魔法与陷阱区域1张怪兽卡在那个正对面的自己的主要怪兽区域特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ヴァリアンツM－マーキス
function c87897777.initial_effect(c)
	aux.AddCodeList(c,75952542)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,87897777)
	e1:SetCondition(c87897777.spcon)
	e1:SetTarget(c87897777.sptg)
	e1:SetOperation(c87897777.spop)
	c:RegisterEffect(e1)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DICE+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,87897778)
	e2:SetTarget(c87897777.dctg)
	e2:SetOperation(c87897777.dcop)
	c:RegisterEffect(e2)
	--dice
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DICE+CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_MOVE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,87897779)
	e3:SetCondition(c87897777.mvcon)
	e3:SetTarget(c87897777.mvtg)
	e3:SetOperation(c87897777.mvop)
	c:RegisterEffect(e3)
end
function c87897777.cfilter(c)
	return c:IsSetCard(0x17d) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsFaceup()
end
function c87897777.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(75952542) or Duel.IsExistingMatchingCard(c87897777.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c87897777.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c87897777.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local zone=1<<c:GetSequence()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP,zone)
	end
end
function c87897777.dctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c87897777.thfilter(c)
	return c:IsSetCard(0x17d) and c:IsAbleToHand()
end
function c87897777.dcop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	Duel.ConfirmDecktop(tp,dc)
	local dg=Duel.GetDecktopGroup(tp,dc)
	local g=dg:Filter(c87897777.thfilter,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(87897777,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
	Duel.ShuffleDeck(tp)
end
function c87897777.mvcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsLocation(LOCATION_MZONE)
		and (c:GetPreviousSequence()~=c:GetSequence() or c:GetPreviousControler()~=tp)
end
function c87897777.spfilter(c,e,tp)
	local zone=1<<c:GetSequence()
	return c:IsFaceup() and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
end
function c87897777.mvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c87897777.spfilter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE)
end
function c87897777.mvop(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	if dc<2 or dc>5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c87897777.spfilter,tp,LOCATION_SZONE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP,1<<tc:GetSequence())
	end
end
