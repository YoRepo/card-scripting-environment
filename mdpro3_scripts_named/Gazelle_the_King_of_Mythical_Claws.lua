--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 幻爪之王 加泽尔  (ID: 23076639)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤的场合才能发动。从卡组把1只恶魔族·5星怪兽或1张「合成兽融合」加入手卡。
-- ②：这张卡成为融合召唤的素材送去墓地的场合才能发动。从卡组把1只幻想魔族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--幻爪の王ガゼル
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,63136489)
	--add fusion/fiend
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetTarget(s.thtg(s.filter))
	e1:SetOperation(s.thop(s.filter))
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--add illusionist
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,id+o)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(s.condition)
	e3:SetTarget(s.thtg(s.ifilter))
	e3:SetOperation(s.thop(s.ifilter))
	c:RegisterEffect(e3)
end
function s.filter(c)
	return (c:IsCode(63136489) or c:IsLevel(5) and c:IsRace(RACE_FIEND)) and c:IsAbleToHand()
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_FUSION and not c:IsReason(REASON_RETURN)
end
function s.ifilter(c)
	return c:IsRace(RACE_ILLUSION) and c:IsAbleToHand()
end
function s.thtg(f)
	return  function(e,tp,eg,ep,ev,re,r,rp,chk)
				if chk==0 then return Duel.IsExistingMatchingCard(f,tp,LOCATION_DECK,0,1,nil) end
				Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
			end
end
function s.thop(f)
	return  function(e,tp,eg,ep,ev,re,r,rp)
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local g=Duel.SelectMatchingCard(tp,f,tp,LOCATION_DECK,0,1,1,nil)
				Duel.SendtoHand(g,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,g)
			end
end
