--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 炎兽之影灵衣-神数艾可萨龙  (ID: 20773176)
-- Type: Monster / Effect / Pendulum
-- Attribute: FIRE
-- Race: Dragon
-- Level 5
-- Pendulum Scales: L7 / R7
-- ATK 2000 | DEF 1000
-- Setcode: 11796676
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：自己不是「影灵衣」怪兽以及「神数」怪兽不能灵摆召唤。这个效果不会被无效化。
-- 【怪兽效果】
-- 「炎兽之影灵衣-神数艾可萨」的怪兽效果1回合只能使用1次。
-- ①：这张卡在手卡·墓地存在，「炎兽之影灵衣-神数艾可萨」以外的自己的怪兽区域·灵摆区域的「影灵衣」卡或者「神数」卡被战斗·效果破坏的场合才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--炎獣の影霊衣－セフィラエグザ
function c20773176.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c20773176.splimit)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCountLimit(1,20773176)
	e3:SetCondition(c20773176.condition)
	e3:SetTarget(c20773176.target)
	e3:SetOperation(c20773176.operation)
	c:RegisterEffect(e3)
end
function c20773176.splimit(e,c,sump,sumtype,sumpos,targetp)
	if c:IsSetCard(0xb4,0xc4) then return false end
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c20773176.filter(c,tp)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsSetCard(0xb4,0xc4) and not c:IsCode(20773176)
		and c:IsPreviousControler(tp)
		and ((c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP))
		or c:IsPreviousLocation(LOCATION_PZONE))
end
function c20773176.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c20773176.filter,1,nil,tp)
end
function c20773176.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c20773176.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
