--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 变形斗士·手机  (ID: 93542102)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 100 | DEF 100
-- Setcode: 38
--
-- Effect Text:
-- ①：这张卡得到表示形式的以下效果。
-- ●攻击表示：1回合1次，自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面翻开。从那之中选1只4星以下的「变形斗士」怪兽无视召唤条件特殊召唤，剩余回到卡组。
-- ●守备表示：1回合1次，自己主要阶段才能发动。掷1次骰子，把出现的数目数量的卡从自己卡组上面确认。
--[[ __CARD_HEADER_END__ ]]

--D・モバホン
function c93542102.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93542102,0))
	e1:SetCategory(CATEGORY_DICE+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c93542102.cona)
	e1:SetTarget(c93542102.tga)
	e1:SetOperation(c93542102.opa)
	c:RegisterEffect(e1)
	--confirm
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(93542102,1))
	e2:SetCategory(CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c93542102.cond)
	e2:SetTarget(c93542102.tgd)
	e2:SetOperation(c93542102.opd)
	c:RegisterEffect(e2)
end
function c93542102.cona(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsAttackPos()
end
function c93542102.cond(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsDisabled() and e:GetHandler():IsDefensePos()
end
function c93542102.tga(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsPlayerAffectedByEffect(tp,63060238)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c93542102.tgd(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c93542102.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x26) and c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c93542102.opa(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	Duel.ConfirmDecktop(tp,dc)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetDecktopGroup(tp,dc)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:FilterSelect(tp,c93542102.filter,1,1,nil,e,tp)
	Duel.SpecialSummon(sg,0,tp,tp,true,false,POS_FACEUP)
	Duel.ShuffleDeck(tp)
end
function c93542102.opd(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	local dc=Duel.TossDice(tp,1)
	local g=Duel.GetDecktopGroup(tp,dc)
	Duel.ConfirmCards(tp,g)
end
