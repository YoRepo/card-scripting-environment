--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 娱乐伙伴 诱导女导演  (ID: 92932860)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 0 | DEF 2000
-- Setcode: 159
--
-- Effect Text:
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：只要自己场上有「异色眼」怪兽存在，对方不能选择这张卡作为攻击对象。
-- ②：只要这张卡在怪兽区域守备表示存在，自己的「异色眼」怪兽不会被战斗破坏，那次战斗发生的对自己的战斗伤害变成0。
-- ③：以自己墓地1只1星怪兽为对象才能发动。那只怪兽效果无效特殊召唤，只用那只怪兽和这张卡为素材作同调召唤。
--[[ __CARD_HEADER_END__ ]]

--EMミス・ディレクター
function c92932860.initial_effect(c)
	--can not be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c92932860.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x99))
	e2:SetCondition(c92932860.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--avoid battle damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x99))
	e3:SetCondition(c92932860.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,92932860)
	e4:SetTarget(c92932860.sctg)
	e4:SetOperation(c92932860.scop)
	c:RegisterEffect(e4)
end
function c92932860.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x99)
end
function c92932860.atcon(e)
	return Duel.IsExistingMatchingCard(c92932860.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c92932860.indcon(e)
	return e:GetHandler():IsDefensePos()
end
function c92932860.scfilter1(c,e,tp,mc)
	local mg=Group.FromCards(c,mc)
	return c:IsLevel(1) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(c92932860.scfilter2,tp,LOCATION_EXTRA,0,1,nil,mg)
end
function c92932860.scfilter2(c,mg)
	return c:IsSynchroSummonable(nil,mg)
end
function c92932860.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c92932860.scfilter1(chkc,e,tp,c) end
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c92932860.scfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c92932860.scfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,tp,LOCATION_EXTRA)
end
function c92932860.scop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or not Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	tc:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	tc:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
	if not c:IsRelateToEffect(e) then return end
	Duel.AdjustAll()
	local mg=Group.FromCards(c,tc)
	if mg:FilterCount(Card.IsLocation,nil,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c92932860.scfilter2,tp,LOCATION_EXTRA,0,nil,mg)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SynchroSummon(tp,sg:GetFirst(),nil,mg)
	end
end
