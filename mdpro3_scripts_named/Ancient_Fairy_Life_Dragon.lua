--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 古代妖精生命龙  (ID: 43321985)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Dragon
-- Level 8
-- ATK 2500 | DEF 3300
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡同调召唤的场合才能发动。自己抽1张。场上有「精灵的世界」存在的场合，作为代替从卡组把1只光属性的兽族·植物族·天使族怪兽或者1张「永久圣阳光」加入手卡。
-- ②：自己的「古代妖精龙」以及有那个卡名记述的怪兽可以用表侧守备表示的状态作出攻击（伤害计算把守备力当作攻击力使用）。
--[[ __CARD_HEADER_END__ ]]

--エンシェント・フェアリー・ライフ・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,25862681,5414777,28903523)
	--Synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw or search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.thcon)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DEFENSE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(s.atktg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function s.thfilter(c)
	return (c:IsCode(28903523) or c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsRace(RACE_BEAST+RACE_FAIRY+RACE_PLANT)) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local flag=Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceupEx,Card.IsCode),tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,5414777)
	if chk==0 then return flag and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil)
		or not flag and Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local flag=Duel.IsExistingMatchingCard(aux.AND(Card.IsFaceupEx,Card.IsCode),tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil,5414777)
	if not flag and Duel.IsPlayerCanDraw(tp,1) then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif flag then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function s.atktg(e,c)
	return c:IsCode(25862681) or aux.IsCodeListed(c,25862681)
end
