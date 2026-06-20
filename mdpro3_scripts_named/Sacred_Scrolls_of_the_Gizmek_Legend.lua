--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 机巧传-神使记纪图  (ID: 24793135)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段才能发动。从自己卡组上面把3张卡翻开。可以从那之中选攻击力和守备力的数值相同的1只机械族怪兽加入手卡。剩下的卡里侧表示除外。
-- ②：每次攻击力和守备力的数值相同的机械族怪兽召唤·特殊召唤给这张卡放置1个指示物。
-- ③：这张卡的指示物数量是10以上的场合，攻击力和守备力的数值不同的场上的怪兽不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--機巧伝－神使記紀図
function c24793135.initial_effect(c)
	c:EnableCounterPermit(0x5d,LOCATION_FZONE)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24793135,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,24793135)
	e2:SetTarget(c24793135.thtg)
	e2:SetOperation(c24793135.thop)
	c:RegisterEffect(e2)
	--counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c24793135.countercon)
	e3:SetOperation(c24793135.counterop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	--act limit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetTargetRange(1,1)
	e5:SetCondition(c24793135.actlimitcon)
	e5:SetValue(c24793135.actlimit)
	c:RegisterEffect(e5)
end
function c24793135.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3 and Duel.IsPlayerCanRemove(tp) end
end
function c24793135.thfilter(c)
	return aux.AtkEqualsDef(c) and c:IsRace(RACE_MACHINE) and c:IsAbleToHand()
end
function c24793135.thop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanRemove(tp) then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<3 then return end
	Duel.ConfirmDecktop(tp,3)
	local g=Duel.GetDecktopGroup(tp,3)
	if g:GetCount()>0 then
		Duel.DisableShuffleCheck()
		if g:IsExists(c24793135.thfilter,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(24793135,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,c24793135.thfilter,1,1,nil)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
			g:Sub(sg)
		end
		Duel.Remove(g,POS_FACEDOWN,REASON_EFFECT+REASON_REVEAL)
	end
end
function c24793135.cfilter(c)
	return aux.AtkEqualsDef(c) and c:IsRace(RACE_MACHINE) and c:IsFaceup()
end
function c24793135.countercon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c24793135.cfilter,1,nil)
end
function c24793135.counterop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x5d,1)
end
function c24793135.actlimitcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0x5d)>=10
end
function c24793135.actlimit(e,re,tp)
	local loc=re:GetActivateLocation()
	local rc=re:GetHandler()
	return loc==LOCATION_MZONE and re:IsActiveType(TYPE_MONSTER) and rc:IsDefenseAbove(0) and not rc:IsDefense(rc:GetAttack())
end
