--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 变形斗士·电话  (ID: 38082437)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 38
--
-- Effect Text:
-- ①：这张卡得到表示形式的以下效果。
-- ●攻击表示：1回合1次，自己主要阶段才能发动。掷1次骰子。自己回复出现的数目×100基本分。那之后，可以从自己墓地选持有出现的数目以下的等级的1只「变形斗士」怪兽特殊召唤。
-- ●守备表示：1回合1次，自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面翻开。可以从那之中选1张「变形斗士」卡送去墓地。剩余用喜欢的顺序回到卡组上面或下面。
--[[ __CARD_HEADER_END__ ]]

--D・テレホン
function c38082437.initial_effect(c)
	--speical summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(38082437,0))
	e1:SetCategory(CATEGORY_DICE+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c38082437.cona)
	e1:SetTarget(c38082437.tga)
	e1:SetOperation(c38082437.opa)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(38082437,2))
	e2:SetCategory(CATEGORY_DICE+CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c38082437.cond)
	e2:SetTarget(c38082437.tgd)
	e2:SetOperation(c38082437.opd)
	c:RegisterEffect(e2)
end
function c38082437.cona(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c38082437.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c38082437.spfilter(c,e,tp,dc)
	return c:IsSetCard(0x26) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(dc)
end
function c38082437.opa(e,tp,eg,ep,ev,re,r,rp)
	local dc=Duel.TossDice(tp,1)
	local rec=dc*100
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c38082437.spfilter),tp,LOCATION_GRAVE,0,nil,e,tp,dc)
	if Duel.Recover(tp,rec,REASON_EFFECT)>0 and g:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(38082437,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:Select(tp,1,1,nil):GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c38082437.cond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos()
end
function c38082437.tgd(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c38082437.tgfilter(c)
	return c:IsSetCard(0x26) and c:IsAbleToGrave()
end
function c38082437.opd(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	Duel.ConfirmDecktop(tp,dc)
	local dg=Duel.GetDecktopGroup(tp,dc)
	local ct=dg:GetCount()
	local g=dg:Filter(c38082437.tgfilter,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(38082437,3)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:Select(tp,1,1,nil)
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_REVEAL)
		ct=ct-1
	end
	local op=Duel.SelectOption(tp,aux.Stringid(38082437,4),aux.Stringid(38082437,5))
	Duel.SortDecktop(tp,tp,ct)
	if op==0 then return end
	for i=1,ct do
		local tg=Duel.GetDecktopGroup(tp,1)
		Duel.MoveSequence(tg:GetFirst(),SEQ_DECKBOTTOM)
	end
end
