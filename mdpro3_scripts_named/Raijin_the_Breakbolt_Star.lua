--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 霸雷星 雷神  (ID: 99991455)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 10
-- ATK 3000 | DEF 2200
--
-- Effect Text:
-- 5星以上的战士族·光属性怪兽＋战士族·地属性怪兽
-- 这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
-- ②：这张卡用和不持有等级的怪兽的战斗给与对方的战斗伤害变成2倍。
-- ③：这张卡被战斗·效果破坏送去墓地的回合的结束阶段，以自己墓地2只7星以下的战士族怪兽为对象才能发动。那些怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--覇雷星ライジン
function c99991455.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c99991455.ffilter1,c99991455.ffilter2,true)
	--pierce
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
	--double battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetCondition(c99991455.damcon)
	e2:SetValue(aux.ChangeBattleDamage(1,DOUBLE_DAMAGE))
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c99991455.regop)
	c:RegisterEffect(e3)
end
function c99991455.ffilter1(c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_WARRIOR) and c:IsFusionAttribute(ATTRIBUTE_LIGHT)
end
function c99991455.ffilter2(c)
	return c:IsRace(RACE_WARRIOR) and c:IsFusionAttribute(ATTRIBUTE_EARTH)
end
function c99991455.damcon(e)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return bc and not bc:IsLevelAbove(0)
end
function c99991455.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:IsReason(REASON_DESTROY) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(99991455,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e1:SetCountLimit(1,99991455)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c99991455.sptg)
		e1:SetOperation(c99991455.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c99991455.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(7) and c:IsRace(RACE_WARRIOR)
end
function c99991455.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c99991455.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and Duel.IsExistingTarget(c99991455.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c99991455.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,2,0,0)
end
function c99991455.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if g:GetCount()>ft then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		g=g:Select(tp,ft,ft,nil)
	end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
