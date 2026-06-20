--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 星圣商神杖使  (ID: 82913020)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1600 | DEF 1550
-- Setcode: 83
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上有「星圣商神杖使」以外的「星圣」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己主要阶段才能发动。从卡组把1张「星圣」魔法·陷阱卡加入手卡。
-- ③：有这张卡在作为超量素材中的「星圣」超量怪兽得到以下效果。
-- ●这张卡和光·暗属性怪兽进行战斗的伤害计算前才能发动。那只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・カドケウス
function c82913020.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82913020,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,82913020)
	e1:SetCondition(c82913020.spcon)
	e1:SetTarget(c82913020.sptg)
	e1:SetOperation(c82913020.spop)
	c:RegisterEffect(e1)
	--Search Spell/Trap
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(82913020,1))
	e2:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,82913021)
	e2:SetTarget(c82913020.srtg)
	e2:SetOperation(c82913020.srop)
	c:RegisterEffect(e2)
	--Unclassified Effect as material
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(82913020,2))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c82913020.mcon)
	e3:SetTarget(c82913020.mtg)
	e3:SetOperation(c82913020.mop)
	c:RegisterEffect(e3)
end
function c82913020.spfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x53) and not c:IsCode(82913020)
end
function c82913020.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c82913020.spfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c82913020.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c82913020.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c82913020.srfilter(c)
	return c:IsSetCard(0x53) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c82913020.srtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82913020.srfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c82913020.srop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c82913020.srfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c82913020.mcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsSetCard(0x53) and c:IsType(TYPE_XYZ) and c:IsRelateToBattle() and bc and bc:IsFaceup()
		and bc:IsAttribute(ATTRIBUTE_LIGHT+ATTRIBUTE_DARK) and bc:IsRelateToBattle()
end
function c82913020.mtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc and bc:IsRelateToBattle() and bc:IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,bc,1,0,0)
end
function c82913020.mop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc and bc:IsRelateToBattle() then
		Duel.Remove(bc,POS_FACEUP,REASON_EFFECT)
	end
end
