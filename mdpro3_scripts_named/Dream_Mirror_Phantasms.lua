--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 梦幻之梦魔镜  (ID: 62171834)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 305
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「梦魔镜」怪兽加入手卡。
-- ②：只要场地区域有「圣光之梦魔镜」存在，自己场上的全部怪兽的攻击力·守备力上升500。
-- ③：只要场地区域有「黯黑之梦魔镜」存在，对方场上的全部怪兽的攻击力·守备力下降500。
--[[ __CARD_HEADER_END__ ]]

--夢幻の夢魔鏡
function c62171834.initial_effect(c)
	aux.AddCodeList(c,74665651,1050355)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,62171834+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c62171834.activate)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(500)
	e2:SetCondition(c62171834.upcon)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--atk/def down
	local e4=e2:Clone()
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetValue(-500)
	e4:SetCondition(c62171834.downcon)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e5)
end
function c62171834.thfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x131) and c:IsAbleToHand()
end
function c62171834.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c62171834.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(62171834,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c62171834.upcon(e)
	return Duel.IsEnvironment(74665651,PLAYER_ALL,LOCATION_FZONE)
end
function c62171834.downcon(e)
	return Duel.IsEnvironment(1050355,PLAYER_ALL,LOCATION_FZONE)
end
